class Admin::ContentTypesController < AdminController
  def index
    @content_types = ContentType.all
  end

  def new
    @content_type = ContentType.new
  end

  def create
    @content_type = ContentType.new(content_type_params)

    if @content_type.save
      redirect_to admin_content_types_path
    else
      render :new
    end
  end

  def edit
    @content_type = ContentType.find(params[:id])
  end

  def update
    @content_type = ContentType.find(params[:id])

    if @content_type.update(content_type_params)
      redirect_to admin_content_types_path
    else
      render :new
    end
  end

  def destroy
    @content_type = ContentType.find(params[:id])
    @content_type.destroy!

    redirect_back(fallback_location: admin_content_types_path)
  end

  private

  def content_type_params
    params.require(:content_type).permit!
  end
end
