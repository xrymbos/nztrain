class ZippedTestDataController < ApplicationController
  # POST /test_cases/bulk_upload
  def upload
    @problem = Problem.find(params[:problem_id])

    zip_file_content = params[:test_cases_zip].read

    any_errors = true

    # TODO: turn zip_file_content into test cases
    # use: TestCase.create(:input => blah, :output => blah, :problem => @problem, etc)
    #
    # note: create automatically calls test_case.save! (new does not)
    #     (that's the difference between new and create, though you probs
    #      knew that :p)
    #
    # how to do it:
    #  for each these "replacements": (in->out), (i->o), (in->ans)
    #     for each file {
    #         if you can apply the replacement and still be in the zip
    #             mark both files off
    #     }
    #     if all files have been marked off exactly once {
    #         go ahead and pair up inputs and outputs, creating test cases.
    #         break.
    #     } else {
    #         any_errors = true (the exact error is:
    #                            invalid, possibly too ambiguous)
    #     }
    #
    # maybe start with just .in and .out to begin with :p

    respond_to do |format|
      if !any_errors
        format.html { redirect_to(edit_problem_path(@problem), :notice => 'Test data successfully uploaded. (actually, not doing anything at the moment)') }
        # what would we want to return if we were looking for an xml response?
        # thinking command line interfacing utilities in the future :)
        #format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { redirect_to(edit_problem_path(@problem), :alert => 'Unable to process bulk upload.') }
        #format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end
end
