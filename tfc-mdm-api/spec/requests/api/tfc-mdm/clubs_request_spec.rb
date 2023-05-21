require 'rails_helper'

RSpec.describe '/api/tfc-mdm/clubs', type: :request do
  let(:base_path) { '/api/tfc-mdm/clubs' }
  
  describe 'GET index' do
    let(:index_path) { base_path }
    let(:headers) { { "Accept" => "application/json" } }

    before(:each) do
      get(index_path, headers: headers)
    end

    describe 'when authenticated' do
      let(:api_token) { create(:cmor_core_api_api_token) }
      let(:headers) do
        {
          "Accept" => "application/json",
          "Authorization" => "Bearer #{api_token.token}"
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body).keys).to match_array(%w[data meta]) }
    end
  end
end
