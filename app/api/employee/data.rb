module Employee
  class Data < Grape::API
    resource :users do
      desc "List all Employee"
      get do
        User.page params[:page]
      end
    end
  end
end
