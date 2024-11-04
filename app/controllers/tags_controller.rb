class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:name))

    if @tag.save
      redirect_to root_path, notice: "Tag adicionada com sucesso"
    end
  end
end