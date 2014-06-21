class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json
  def index  
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.where(
      id:      params[:id],
      user_id: session[:user_id]
    )[0]

    if @note
      @note
    else
      redirect_to "/notes"
    end
    
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  #GET /notes/list
  def list
    @notes = Note.where user_id: session[:user_id]
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])
    @note.user_id = session[:user_id]

    
    if @note.save
      redirect_to "/notes/#{@note.id}"
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
