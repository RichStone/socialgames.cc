class Account::GamingSessionsController < Account::ApplicationController
  account_load_and_authorize_resource :gaming_session, through: :team, through_association: :gaming_sessions

  # GET /account/teams/:team_id/gaming_sessions
  # GET /account/teams/:team_id/gaming_sessions.json
  def index
    delegate_json_to_api
  end

  # GET /account/gaming_sessions/:id
  # GET /account/gaming_sessions/:id.json
  def show
    delegate_json_to_api
  end

  # GET /account/teams/:team_id/gaming_sessions/new
  def new
  end

  # GET /account/gaming_sessions/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/gaming_sessions
  # POST /account/teams/:team_id/gaming_sessions.json
  def create
    respond_to do |format|
      if @gaming_session.save
        format.html { redirect_to [:account, @gaming_session], notice: I18n.t("gaming_sessions.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @gaming_session] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gaming_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/gaming_sessions/:id
  # PATCH/PUT /account/gaming_sessions/:id.json
  def update
    respond_to do |format|
      if @gaming_session.update(gaming_session_params)
        format.html { redirect_to [:account, @gaming_session], notice: I18n.t("gaming_sessions.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @gaming_session] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gaming_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/gaming_sessions/:id
  # DELETE /account/gaming_sessions/:id.json
  def destroy
    @gaming_session.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :gaming_sessions], notice: I18n.t("gaming_sessions.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  if defined?(Api::V1::ApplicationController)
    include strong_parameters_from_api
  end

  def process_params(strong_params)
    assign_date_and_time(strong_params, :finished_at)
    # 🚅 super scaffolding will insert processing for new fields above this line.
  end
end
