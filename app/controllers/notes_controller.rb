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

      render layout: false
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

   #GET /notes/list
   def list
      @notes = Note.where user_id: session[:user_id]
   end

   # POST /notes
   # POST /notes.json
   def create
      @note = Note.new(
         title:   params[:note][:title],
         body:    digest_secure.enc(params[:note][:body]),
         user_id: session[:user_id]
      )

      if @note.save
         redirect_to @note
      end
   end

   # PUT /notes/1
   # PUT /notes/1.json
   def update
      @note = Note.where(
         id:      params[:id],
         user_id: session[:user_id]
      ).first

      if @note
         @note.body = digest_secure.enc(params[:body])

         @note.save
         response = {:message => "Note updated!", code: 200}
      else
         response = {:message => "Note cannot be updated", code: 500}
      end
     
     render :json => response.to_json
   end

   # DELETE /notes/1
   # DELETE /notes/1.json
   def destroy
      @note = Note.where(
         id: params[:id],
         user_id: session[:user_id]
      ).first

      @note.destroy if @note

      redirect_to "/notes/list"
   end

   private
   def digest_secure
      Gibberish::AES.new(session[:c_key])
   end
end
