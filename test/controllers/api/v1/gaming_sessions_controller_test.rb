require "controllers/api/v1/test"

class Api::V1::GamingSessionsControllerTest < Api::Test
  setup do
    # See `test/controllers/api/test.rb` for common set up for API tests.

    @gaming_session = build(:gaming_session, team: @team)
    @other_gaming_sessions = create_list(:gaming_session, 3)

    @another_gaming_session = create(:gaming_session, team: @team)

    # 🚅 super scaffolding will insert file-related logic above this line.
    @gaming_session.save
    @another_gaming_session.save

    @original_hide_things = ENV["HIDE_THINGS"]
    ENV["HIDE_THINGS"] = "false"
    Rails.application.reload_routes!
  end

  teardown do
    ENV["HIDE_THINGS"] = @original_hide_things
    Rails.application.reload_routes!
  end

  # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
  # data we were previously providing to users _will_ break the test suite.
  def assert_proper_object_serialization(gaming_session_data)
    # Fetch the gaming_session in question and prepare to compare it's attributes.
    gaming_session = GamingSession.find(gaming_session_data["id"])

    assert_equal_or_nil DateTime.parse(gaming_session_data['finished_at']), gaming_session.finished_at
    assert_equal_or_nil gaming_session_data['note'], gaming_session.note
    assert_equal_or_nil gaming_session_data['with_cheating'], gaming_session.with_cheating
    # 🚅 super scaffolding will insert new fields above this line.

    assert_equal gaming_session_data["team_id"], gaming_session.team_id
  end

  test "index" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/teams/#{@team.id}/gaming_sessions", params: {access_token: access_token}
    assert_response :success

    # Make sure it's returning our resources.
    gaming_session_ids_returned = response.parsed_body.map { |gaming_session| gaming_session["id"] }
    assert_includes(gaming_session_ids_returned, @gaming_session.id)

    # But not returning other people's resources.
    assert_not_includes(gaming_session_ids_returned, @other_gaming_sessions[0].id)

    # And that the object structure is correct.
    assert_proper_object_serialization response.parsed_body.first
  end

  test "show" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/gaming_sessions/#{@gaming_session.id}", params: {access_token: access_token}
    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    get "/api/v1/gaming_sessions/#{@gaming_session.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "create" do
    # Use the serializer to generate a payload, but strip some attributes out.
    params = {access_token: access_token}
    gaming_session_data = JSON.parse(build(:gaming_session, team: nil).api_attributes.to_json)
    gaming_session_data.except!("id", "team_id", "created_at", "updated_at")
    params[:gaming_session] = gaming_session_data

    post "/api/v1/teams/#{@team.id}/gaming_sessions", params: params
    assert_response :success

    # # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    post "/api/v1/teams/#{@team.id}/gaming_sessions",
      params: params.merge({access_token: another_access_token})
    assert_response :not_found
  end

  test "update" do
    # Post an attribute update ensure nothing is seriously broken.
    put "/api/v1/gaming_sessions/#{@gaming_session.id}", params: {
      access_token: access_token,
      gaming_session: {
        note: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }
    }

    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # But we have to manually assert the value was properly updated.
    @gaming_session.reload
    assert_equal @gaming_session.note, 'Alternative String Value'
    # 🚅 super scaffolding will additionally insert new fields above this line.

    # Also ensure we can't do that same action as another user.
    put "/api/v1/gaming_sessions/#{@gaming_session.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "destroy" do
    # Delete and ensure it actually went away.
    assert_difference("GamingSession.count", -1) do
      delete "/api/v1/gaming_sessions/#{@gaming_session.id}", params: {access_token: access_token}
      assert_response :success
    end

    # Also ensure we can't do that same action as another user.
    delete "/api/v1/gaming_sessions/#{@another_gaming_session.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end
end
