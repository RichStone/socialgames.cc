class Avo::Resources::MatchesJoinedPlayer < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  self.model_class = ::Matches::JoinedPlayer
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :match, as: :belongs_to
    field :player, as: :belongs_to
  end
end
