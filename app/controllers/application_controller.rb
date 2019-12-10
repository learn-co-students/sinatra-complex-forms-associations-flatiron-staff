class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  patch '/owners/:id' do
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

    @owner = Owner.find(params[:id])
    @owner.name = params["owner"]["name"]
    @owner.pet_ids = params["owner"]["pet_ids"]

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    @owner.save

    redirect "owners/#{@owner.id}"
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])

    if params[:owner_name].length > 0
      owner = Owner.create!(name: params[:owner_name])
    else
      owner = Owner.find(params[:pet_owner])
    end

    @pet.update!(name: params[:pet_name], owner_id: owner)
    owner.pets << @pet unless owner.pets.include?(@pet)

    redirect to "pets/#{@pet.id}"
  end
end
