class TransactionsController < ApplicationController
   
    def create
        raise ::Errors::CustomError.new(:bad_request, 403, "Account is not authorized to do that aciton unless verified") if current_account&.status == "unverified"

        transaction = Transaction.new
        transaction.giver = current_account
        unless transactions_params[:phone_number].blank?
            recevier = Account.where(phone_number: transactions_params[:phone_number]).first
        else
            recevier = Account.where(email: transactions_params[:email]).first
        end
        transaction.recevier = recevier
        transaction.amount = transactions_params[:amount]
        if transaction.save
            render json: { transaction: transaction }, status: 200
        else
            render json: { errors: transaction.errors.full_messages }, status: 300
        end
    end

    private

    def transactions_params
       params.permit(:phone_number, :email, :amount) 
    end
end
  