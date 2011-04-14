class Submission < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  validates_associated :problem, :user
  validates_presence_of :problem, :user, :message => "is invalid"

  validates_presence_of :source

  # handle file uploads as well as simple text
  def source_upload=(upload)
      self.source = upload.read;
  end

  # TODO: make sure this runs past the end of the HTTP request somehow...
  def judge
    working_directory = '/tmp/submission_' + id.to_s + '/'
    Dir.mkdir(working_directory)
    Dir.chdir(working_directory)

    source_file = 'program.c'
    exe_file = 'program.exe'

    File.open(source_file, 'w') { |f| f.write(source) }

    comp_sandbox_opts='-m262144 -w60 -e -i/dev/null'
    comp_output = `box #{comp_sandbox_opts} -- /usr/bin/gcc #{source_file} -o #{exe_file}`

    # TODO: check compiler output here (compile errors, warnings, etc)

    input_file = problem.input
    output_file = problem.output

    judge_file = "judge.info"

    mem_limit = problem.memory_limit * 1024
    stack_limit = 1024 * 4
    time_limit = problem.time_limit

    self.score = 0
    total_points = 0

    problem.test_cases.each do |test_case|
      File.open(input_file, 'w') { |f| f.write(test_case.input) }

      system("box -a2 -f -M#{judge_file} -m#{mem_limit} -k#{stack_limit} " +
             " -t#{time_limit} -o/dev/null -r/dev/null -- #{exe_file}" )

      print File.open(judge_file, 'r') { |f| f.read } + "\n"
      their_output = File.open(output_file, 'r') { |f| f.read }

      # TODO: different evaluators.
      actual = their_output.split('\n').each{|s|s.strip!}.join('\n')
      expected = test_case.output.split('\n').each{|s| s.strip!}.join('\n')

      self.score += test_case.points if actual == expected
      total_points += test_case.points

      # TODO: error checking necessary here?
      # or ruby exceptions takes care of it?
      File.delete(input_file)
      File.delete(output_file)
    end

    self.score *= 100
    self.score /= total_points

    self.save

    File.delete(source_file)
    File.delete(exe_file)
    File.delete(judge_file)
    Dir.chdir('/')
    Dir.rmdir(working_directory)

    # system("box", "OPTS", "gcc", "file.c")
    # Sandbox options used when compiling

    # compile program
    # total = 0
    # for all test cases associated with this problem
    #     run program on test case
    #     total += evaluation of answer
    # return total


    # all opts, etc are taken from eval/eval/eval.cf (see moe)
    # maybe at some point actually parse this file?
    # depends if we want to be coupled to moe (probably not...)

    # to run soln
    # system("box", "OPTS", "soln")
    #
    # Sandbox options used when testing
    # TEST_SANDBOX_OPTS='-a2 -f -m$MEM_LIMIT -k$STACK_LIMIT -t$TIME_LIMIT $LANG_SANDBOX_OPTS $BOX_EXTRAS'

    # C
    #EXT_c_COMP='/usr/bin/gcc -std=gnu99 -O2 -g -o $EXE $EXTRA_CFLAGS $SRC -lm'
    # EXTRA_CFLAGS=

    # C++
    # EXT_cpp_COMP='/usr/bin/g++ -O2 -g -o $EXE $EXTRA_CXXFLAGS $SRC -lm'
    #EXTRA_CXXFLAGS=

    # Pascal
    #  EXT_pas_COMP='/usr/bin/fpc -Ci -g -O2 -Sg -o$EXE $EXTRA_PFLAGS $SRC'
    # EXTRA_PFLAGS=
  end
end
