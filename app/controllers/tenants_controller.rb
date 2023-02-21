class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :response_not_valid

    def index
        render json: Tenant.all
    end

    def update
        @tenant.update!(tenant_params)
        render json: @tenant, status: :accepted
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        @tenant.destroy
        head :no_content
    end

    private

    def set_tenant
        @tenant = Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def response_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def response_not_valid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
