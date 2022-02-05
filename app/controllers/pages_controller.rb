class PagesController < ApplicationController
    def show
        if valid_page?
            render template: "pages/#{params[:page]}"
        else
            render file: "public/404.html", status: :not_found
        end
    end

    def resume
        send_file("#{Rails.root}/files/VYee_Resume.pdf", filename: "VYee_Resume.pdf", type: "application/pdf")
    end

    private

    def valid_page?
        File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end
end
