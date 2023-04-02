require 'swagger_helper'

RSpec.describe ForestsController, type: :request do
  path '/forests' do
    get "Retrieves all forests" do
      tags 'Forests'
      produces 'application/json', 'application/xml'

      response '200', 'Forests found' do
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer},
            name: {type: :string},
            state: { type: :string}
          },
          required: ['id', 'name', 'state']
        }

        before { create_list(:forest, 3) }
        run_test!
      end

      response '404', 'Forests not found' do
        run_test!
      end
    end

    post 'Create a forest' do
      tags 'Forests'
      consumes 'application/json'
      parameter name: :forest, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string},
          state: {type: :string}
        },
        required: ['name', 'state']
      }

      response '201', 'Forests created' do
        let(:forest) { { name: 'New Forest', state: 'New State' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:forest) { { name: nil, state: nil } }
        run_test!
      end
    end
  end

  path '/forests/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieve a forest' do
      tags 'Forests'
      produces 'application/json'

      response '200', 'Forest Found' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          state: { type: :string}
        },

        required: ['id', 'name', 'state']

        let(:forest) { create(:forest) }
        let(:id) { forest.id }
        run_test!
      end

      response '404', 'Forest not Found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a forest' do
      tags 'Forests'
      consumes 'application/json'
      parameter name: :forest, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          state: { type: :string }
        },
        required: [ 'name', 'state' ]
      }

      response '200', 'Forest updated' do
        let(:forest) { create(:forest) }
        let(:id) { forest.id }
        let(:name) { 'Updated Name' }
        let(:state) { 'Updated State' }
        run_test!
      end

      # response '422', 'Invalid request' do
      #   let(:forest) { create(:forest) }
      #   let(:id) { forest.id }
      #   let(:name) { 12 }
      #   let(:state) { 12 }
      #   run_test!
      # end
    end

    delete 'Deletes a forest' do
      tags 'Forests'
      produces 'application/json'

      response '200', 'Forest deleted' do
        let(:forest) { create(:forest) }
        let(:id) { forest.id }
        run_test!
      end

      response '404', 'Forest not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
