class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found

    def index
        render json: Apartment.all
    end

    def update
        @apartment.update(apartment_params)
        render json: @apartment, status: :accepted
    end

    def create
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created
    end

    def destroy
        @apartment.destroy
        head :no_content
    end

    private

    def set_apartment
        @apartment = Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:name, :age)
    end

    def response_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end
end
