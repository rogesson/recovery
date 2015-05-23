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
      @notes = Note.where(user_id: session[:user_id]).order("id desc")
   end

   def create
      body = DigestManager.enc(params[:note][:body], session[:c_key])
      
      @note = Note.create(title: params[:note][:title], body: body, user_id: session[:user_id])
      
      redirect_to "/notes/list"
   end

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
