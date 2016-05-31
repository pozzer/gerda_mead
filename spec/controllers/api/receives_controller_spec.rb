require 'rails_helper'

RSpec.describe Api::ReceivesController, type: :controller do
  before do
    set_token
  end

  let(:resource_class) { FactoryGirl.create(:resource_class, name: valid_attributes[:resource_class_name]) }
  let(:resource_type) { FactoryGirl.create(:resource_type, resource_class: resource_class, account: @current_system.account) }
  let(:resource) { FactoryGirl.create(:resource, resource_type: resource_type) }
  let(:resource_object) { FactoryGirl.create(:resource_object, object_ref: valid_attributes[:object_ref_id], resource: resource, system: @current_system) }

  let(:valid_attributes) {
    {
      "resource_class_name": "Usuario",
      "object_ref_id": 2,
      "object_attributes": {
        "id": 2,
        "nome": "Novo Usuário"
      }
    }
  }

  context "POST #create" do
    context "when get error" do
      describe "if not found resource class" do
        it "render Unprocessable Entity" do
          expected = {"error" => "Resource Class not found"}
          post :create, {create: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            post :create, {create: valid_attributes}
            }.to change(Log.post_received.warning, :count).by(1)
          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end

      describe "if not found resource type" do
        it "render Unprocessable Entity" do
          FactoryGirl.create(:resource_class, name: valid_attributes[:resource_class_name])

          expected = {"error" => "Resource Type not found"}
          post :create, {create: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            post :create, {create: valid_attributes}
            }.to change(Log.post_received.warning, :count).by(1)
          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end

      describe "if found resource object" do
        it "render Unprocessable Entity" do
          resource_object

          expected = {"error" => "Object already exists"}
          post :create, {create: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            post :create, {create: valid_attributes}
            }.to change(Log.post_received.warning, :count).by(1)
          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end
    end

    context "when get success" do
      before do
        resource_type
      end

      it "creates a new Resource" do
        expect {
          post :create, {create: valid_attributes}
        }.to change(Resource, :count).by(1)
      end

      it "creates a new ResourceObject" do
        expect {
          post :create, {create: valid_attributes}
        }.to change(ResourceObject, :count).by(1)
      end

      it "render resource_object_id" do
        post :create, {create: valid_attributes}

        expected = {"resource_object_id" => ResourceObject.last.id}

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected)
        expect(response.status).to eq(201)
      end

      it "create log" do
        expect {
          post :create, {create: valid_attributes}
          }.to change(Log.post_received.success, :count).by(1)

        expect(Log.last.parameters).to eq({"id"=>"2", "nome"=>"Novo Usuário"})
      end
    end

    it "enqueue a SyncCreateJob with other system" do
      system2 = create(:system, account: @current_account)
      expect(Resource).to receive(:create).and_return(resource)
      attributes = {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}
      expect { post :create, {create: valid_attributes} }.to enqueue_a(SyncCreateJob).with(system2.id, resource.id, attributes)
    end

    it "enqueue a SyncCreateJob for each other system" do
      system2 = create(:system, account: @current_account)
      system3 = create(:system, account: @current_account)
      system4 = create(:system, account: @current_account)
      expect(Resource).to receive(:create).and_return(resource)

      post :create, {create: valid_attributes}

      expect(ActiveJob::Base.queue_adapter.enqueued_jobs).to match_array([
        {:job=>SyncCreateJob, :args=>[system2.id, resource.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"create"},
        {:job=>SyncCreateJob, :args=>[system3.id, resource.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"create"},
        {:job=>SyncCreateJob, :args=>[system4.id, resource.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"create"}
      ])
    end

  end

  context "PUT #update" do
    context "when get error" do
      describe "if not found resource class" do
        it "render Unprocessable Entity" do
          expected = {"error" => "Resource Class not found"}
          put :update, {update: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            put :update, {update: valid_attributes}
            }.to change(Log.put_received.warning, :count).by(1)

          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end

      describe "if not found resource type" do
        it "render Unprocessable Entity" do
          FactoryGirl.create(:resource_class, name: valid_attributes[:resource_class_name])

          expected = {"error" => "Resource Type not found"}
          put :update, {update: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            put :update, {update: valid_attributes}
            }.to change(Log.put_received.warning, :count).by(1)
          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end

      describe "if not found resource object" do
        it "render Unprocessable Entity" do
          resource_type

          expected = {"error" => "Object not exists"}
          put :update, {update: valid_attributes}

          response_body = JSON.parse(response.body)

          expect(response_body).to eq(expected)
          expect(response.status).to eq(422)
        end

        it "create log" do
          expect {
            put :update, {update: valid_attributes}
            }.to change(Log.put_received.warning, :count).by(1)
          expect(Log.last.parameters).to eq({"resource_class_name"=>"Usuario", "object_ref_id"=>"2", "object_attributes"=>{"id"=>"2", "nome"=>"Novo Usuário"}})
        end
      end
    end

    context "when get success" do
      before do
        resource_object
      end

      it "assigns the resource object" do
        put :update, {update: valid_attributes}

        expect(assigns(:resource_object)).to eq (resource_object)
      end

      it "render OK" do
        put :update, {update: valid_attributes}

        expected = {"success" => "OK"}

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected)
        expect(response.status).to eq(201)
      end

      it "create log" do
        expect {
          put :update, {update: valid_attributes}
          }.to change(Log.put_received.success, :count).by(1)
        expect(Log.last.parameters).to eq({"id"=>"2", "nome"=>"Novo Usuário"})
      end

      it "enqueue a SyncUpdateJob with other system" do
        system2 = create(:system, account: @current_account)
        res_object2 = create(:resource_object, system: system2, resource: resource)
        attributes = {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}
        expect { put :update, {update: valid_attributes} }.to enqueue_a(SyncUpdateJob).with(system2.id, resource.id, res_object2.id, attributes)
      end

      it "enqueue a SyncUpdateJob for each other system" do
        system2 = create(:system, account: @current_account)
        res_object2 = create(:resource_object, system: system2, resource: resource)
        system3 = create(:system, account: @current_account)
        res_object3 = create(:resource_object, system: system3, resource: resource)
        system4 = create(:system, account: @current_account)
        res_object4 = create(:resource_object, system: system4, resource: resource)

        put :update, {update: valid_attributes}

        expect(ActiveJob::Base.queue_adapter.enqueued_jobs).to match_array([
          {:job=>SyncUpdateJob, :args=>[system2.id, resource.id, res_object2.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"update"},
          {:job=>SyncUpdateJob, :args=>[system3.id, resource.id, res_object3.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"update"},
          {:job=>SyncUpdateJob, :args=>[system4.id, resource.id, res_object4.id, {"id"=>"2", "nome"=>"Novo Usuário", "_aj_hash_with_indifferent_access"=>true}], :queue=>"update"}
        ])
      end

    end
  end
end
