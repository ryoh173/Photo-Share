class PhotosController < ApplicationController
   before_action :authenticate_user!
   before_action :set_photo, only: [:edit, :update, :destroy]

  def top
  end

  def index
    @photos = Photo.all
  end

  def new
   if params[:back]
     @photo = Photo.new(photos_params)
   else
     @photo = Photo.new
   end
  end

  def create
    @photo = Photo.new(photos_params)
    # @photo.user_id = current_user.id
    if @photo.save
      redirect_to photos_path, notice: "写真を投稿しました！"
      NoticeMailer.sendmail_photo(@photo).deliver
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @photo.update(photos_params)
    redirect_to photos_path, notice: "写真を編集しました！"
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: "写真を削除しました！"
  end

  private
    def photos_params
      params.require(:photo).permit(:title, :content)
    end

    def set_photo
      @photo = Photo.find(params[:id])
    end
end
