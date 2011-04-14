class SubmissionsController < ApplicationController

  before_filter :authenticate_user!

  # GET /submissions
  # GET /submissions.xml
  def index
    # TODO: only show YOUR submissions

    @submissions = Submission.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.xml
  def show
    @submission = Submission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.xml
  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    # TODO: WORK OUT WHETHER ADMINS CAN MODIFY SUBMISSIONS (e.g. EXAMS)
    # (known as "tears" at UNSW)
    redirect_to(submissions_path, :alert => 'Unable to modify submissions at this time')
    return;
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.xml
  def create

    # TODO: ENSURE USER HAS ACCESS TO THE PROBLEM

    # TODO: log users who try to submit as other users
    #     (i.e. work out who the hacker kids are for curiosity sake)

    params[:submission][:user_id] = current_user

    @submission = Submission.new(params[:submission])

    respond_to do |format|
      if @submission.save

        # TODO: arrange for submission to be added to judging queue
        @submission.judge

        format.html { redirect_to(@submission, :notice => 'Submission was successfully created.') }
        format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.xml
  def update
    # TODO: WORK OUT WHETHER ADMINS CAN MODIFY SUBMISSIONS (e.g. EXAMS)
    # (known as "tears" at UNSW)
    redirect_to(submissions_path, :alert => 'Unable to modify submissions at this time')
    return;

    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to(@submission, :notice => 'Submission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.xml
  def destroy
    # TODO: WORK OUT WHETHER ADMINS/STUDENTS CAN DELETE SUBMISSIONS
    redirect_to(submissions_path, :alert => 'Unable to delete submissions at this time')
    return;

    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to(submissions_url) }
      format.xml  { head :ok }
    end
  end
end
