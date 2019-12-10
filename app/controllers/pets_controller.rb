class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do
    if params[:owner_name].length > 0
      owner = Owner.create(name: params[:owner_name])
    else
      owner = Owner.find(params[:pet_owner])
    end

    @pet = Pet.create!(owner: owner, name: params[:pet_name])
    owner.pets << @pet

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])

    if params[:owner][:name].length > 0
      owner = Owner.create!(name: params[:owner][:name])
    else
      owner = Owner.find(params[:pet_owner])
    end

    @pet.update!(name: params[:pet_name], owner_id: owner)
    owner.pets << @pet unless owner.pets.include?(@pet)

    redirect to "pets/#{@pet.id}"
  end
end
