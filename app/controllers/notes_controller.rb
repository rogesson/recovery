class NotesController < ApplicationController
   def index;end

   def show
      @note = Note.where(id: params[:id], user_id: session[:user_id]).first
      render layout: false
   end

   def new
      @note = Note.new

      render layout: false
   end

   def list
      @notes = Note.where user_id: session[:user_id]
   end

   def create
      body = DigestManager.enc(params[:note][:body], session[:c_key])
      @note = Note.new(title: params[:note][:title], body: body, user_id: session[:user_id])

      if @note.save
         redirect_to "/notes/list"
      end
   end

   def update
      @note = Note.where(id: params[:id], user_id: session[:user_id]).first

      if @note
         @note.body = DigestManager.enc(params[:body], session[:c_key])

         @note.save
         response = {:message => "Note updated!", code: 200}
      else
         response = {:message => "Note cannot be updated", code: 500}
      end
     
     render :json => response.to_json
   end

   def destroy
      @note = Note.where(
         id: params[:id],
         user_id: session[:user_id]
      ).first

      if @note.destroy
         response = {:message => "Note updated!", code: 200}
      else
         response = {:message => "Note cannot be updated", code: 500}
      end

      render :json => response.to_json
   end
   
end
