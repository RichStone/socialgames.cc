class Avo::Resources::GamingSession < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :team, as: :belongs_to
    field :finished_at, as: :date_time
    field :note, as: :textarea
    field :with_cheating, as: :boolean
  end
end
