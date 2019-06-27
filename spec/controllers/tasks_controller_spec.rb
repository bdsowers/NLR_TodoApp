require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe "GET #index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template(:index)
		end

		it "returns all the tasks" do
			get :index
			expect(assigns(:tasks)).not_to be_nil
		end
	end

	describe "GET #new" do
		it "renders the new template" do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns a new task to @task" do
			get :new
			expect(assigns(:task)).to be_a_new(Task)
		end
	end

	describe "GET #show" do
		it "assigns the requested task to @task" do
			task = create(:homework)
			get :show, params: { id: task.to_param }
			expect(assigns(:task)).to eq(task)
		end

		it "renders the show template" do
			task = create(:homework)
			get :show, params: { id: task.to_param }
			expect(response).to render_template(:show)
		end
	end

	describe "GET #edit" do
		it "assigns the requested task to @task" do
			task = create(:homework)
			get :edit, params: { id: task.to_param }
			expect(assigns(:task)).to eq(task)
		end

		it "renders the edit template" do
			task = create(:homework)
			get :edit, params: { id: task.to_param }
			expect(response).to render_template(:edit)
		end
	end

	describe "POST #create" do
		let(:user) { create(:user) }
		let(:valid_attributes) { attributes_for(:email, user_id: user.id) }
		let(:invalid_attributes) { attributes_for(:invalid_task) }

		context "with valid attributes" do
			it "creates a new task that is saved to the db" do
				expect {
					post :create, params: { task: valid_attributes }
				}.to change(Task, :count).by(1)
			end

			it "redirects to the show page" do
				post :create, params: { task: valid_attributes }
				expect(response).to redirect_to(assigns(:task))
			end
		end

		context "with invalid attributes" do
			it "does not save a task to the db" do
				expect {
					post :create, params: { task: invalid_attributes }
				}.not_to change(Task, :count)
			end

			it "re-renders new template" do
				post :create, params: { task: invalid_attributes }
				expect(response).to render_template(:new)
			end
		end
	end

	describe "PATCH #update" do
		let(:task) { create(:email) }
		let(:new_attributes) { attributes_for(:homework) }
		let(:invalid_attributes) { attributes_for(:invalid_task) }

		context "with valid params" do
			it "updates the task" do
				patch :update, params: { id: task.to_param, task: new_attributes}
				task.reload

				expect(task.name).to eq("Do your homework")
				expect(task.priority).to eq(1)
			end

			it "redirects to the show task page" do
				patch :update, params: { id: task.to_param, task: new_attributes }
				task.reload

				expect(response).to redirect_to(task)
			end
		end

		context "with invalid params" do
			it "does not change the task" do
				patch :update, params: { id: task.to_param, task: invalid_attributes }
				task.reload

				expect(assigns(:task)).to eq(task)
			end

			it "re-renders the edit template" do
				patch :update, params: { id: task.to_param, task: invalid_attributes }
				expect(response).to render_template(:edit)
			end
		end
	end

	describe "DELETE #destroy" do
		let(:task) { build(:homework) }

		it "destroys the requested task" do
			task.save
			expect {
				delete :destroy, params: { id: task.to_param }
			}.to change(Task, :count).by(-1)
		end

		it "redirects to the task list" do
			task.save
			delete :destroy, params: { id: task.to_param }
			expect(response).to redirect_to(tasks_path)
		end
	end
end
