# Api::V1::ApplicationController is in the starter repository and isn't
# needed for this package's unit tests, but our CI tests will try to load this
# class because eager loading is set to `true` when CI=true.
# We wrap this class in an `if` statement to circumvent this issue.
if defined?(Api::V1::ApplicationController)
  class Api::V1::GamingSessionsController < Api::V1::ApplicationController
    account_load_and_authorize_resource :gaming_session, through: :team, through_association: :gaming_sessions

    # GET /api/v1/teams/:team_id/gaming_sessions
    def index
    end

    # GET /api/v1/gaming_sessions/:id
    def show
    end

    # POST /api/v1/teams/:team_id/gaming_sessions
    def create
      if @gaming_session.save
        render :show, status: :created, location: [:api, :v1, @gaming_session]
      else
        render json: @gaming_session.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/gaming_sessions/:id
    def update
      if @gaming_session.update(gaming_session_params)
        render :show
      else
        render json: @gaming_session.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/gaming_sessions/:id
    def destroy
      @gaming_session.destroy
    end

    private

    module StrongParameters
      # Only allow a list of trusted parameters through.
      def gaming_session_params
        strong_params = params.require(:gaming_session).permit(
          *permitted_fields,
          :finished_at,
          :note,
          :with_cheating,
          # 🚅 super scaffolding will insert new fields above this line.
          *permitted_arrays,
          # 🚅 super scaffolding will insert new arrays above this line.
        )

        process_params(strong_params)

        strong_params
      end
    end

    include StrongParameters
  end
else
  class Api::V1::GamingSessionsController
  end
end
