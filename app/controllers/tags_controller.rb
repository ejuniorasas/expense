class TagsController < ApplicationController

    # GET /tags
    # GET /tas.json
    def index
        all_user_tags =[]
        @user.clan.users.each do |user|
            user.tags.each do |tag| 
                all_user_tags.push(tag.tag)
            end
        end
        render json: all_user_tags
    end
    
end