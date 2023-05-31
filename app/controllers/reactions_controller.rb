class ReactionsController < ApplicationController
    before_action :authenticate_user!

    def product_with_reactions 
        @reactions = current_user.reactions 
        product_ids = @reactions.map(&:product_id)
        @products = Product.where(id: product_ids)
    end

    def user_reaction 
        @user = current_user 
        @product = Product.find(params[:product_id])
        reaction = Reaction.find_by(user_id: @user.id, product_id: @product.id)
        if reaction 
            respond_to do |format|
                format.html { redirect_to product_path(@product), notice: "Ya hay una reacción" }
            end
        else  
            @new_reaction = Reaction.new(user_id: @user.id, product_id: @product.id, kind: params[:kind])
            respond_to do |format|
                if @new_reaction.save!
                  format.html { redirect_to product_path(@product), notice: "#{current_user.email} ha reaccionado con un #{@new_reaction.kind}" }
                else
                  format.html { redirect_to product_path(@product), status: :unprocessable_entity }
                end
            end
        end
    end
end
