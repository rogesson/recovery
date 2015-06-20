class NotesController < ApplicationController
   def index;end

   # TODO refatorar
   def show
      @note = Note.where(id: params[:id], user_id: session[:user_id]).first
      render layout: false
   end

   # TODO refatorar
   def new
      @note = Note.new
      render layout: false
   end

   # TODO refatorar
   def list
      @notes = Note.where(user_id: session[:user_id]).order("id desc")
   end

   # TODO refatorar
   def create
      body = DigestManager.enc(params[:note][:body], session[:c_key])
      
      @note = Note.create(title: params[:note][:title], body: body, user_id: session[:user_id])
      
      redirect_to "/notes/list"
   end

   # TODO refatorar
   def update
      @note = Note.where(id: params[:id], user_id: session[:user_id]).first
      @note.body = DigestManager.enc(params[:body], session[:c_key])

      response = 
         if @note.save
            "success"
         else
            "error"
         end
     
     render :json => { :response => response }.to_json
   end

   # TODO refatorar
   def destroy
      @note = Note.where(id: params[:id], user_id: session[:user_id]).first

      response =
         if @note.destroy
            "success"
         else
            "error" 
         end

      render :json => { :response => response }.to_json
   end

end
