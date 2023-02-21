class LeaseController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end


    def destroy
        @lease.destroy
        head :no_content
    end


    private

    def set_lease
        @lease = Lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def record_not_found
        render json: {error: "Lease not found"}, status: :not_found
    end
end
