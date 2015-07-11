class NotesController < ApplicationController
   before_filter :set_user
   before_filter :set_note, only: [:update, :destroy, :show]
   
   def index
      @notes_result = @user.note
   end

   def new
      @note = Note.new
      
      render layout: false
   end

   def create
      note = @user.note.new(params[:note])
      response = note.save ? 'success' : note.errors

      render js: { response: response }
   end

   def show
      @note

      render layout: false
   end

   def update 
      response = @note.update_attributes(params[:note]) ? 'success' : @note.errors

      render json: { response: response }
   end

   def destroy
      response = @note.destroy ? 'success' : @note.errors

      render json: { response: response }
   end

   private

   def set_user
      @user = User.where(id: session[:user_id]).first
   end

   def set_note
      @note = @user.note.where(id: params[:id]).first
   end
end
