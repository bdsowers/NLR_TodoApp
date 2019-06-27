require 'rails_helper'

feature 'tasks/index' do
	scenario 'shows a list of tasks' do
		create(:homework)
		create(:email)

		visit tasks_path

		expect(page).to have_content('Do your homework')
		expect(page).to have_content('Write an e-mail')
	end
end

feature 'New Task' do
	scenario 'user adds a new task' do
		user = create(:user)
		visit tasks_path

		expect {
			click_link 'New Task'
			fill_in 'Name', with: 'Learn Rspec'
			fill_in 'Priority', with: 2
			fill_in 'Due date', with: DateTime.now
			select(user.email, from: 'task_user_id')
			click_button 'Create Task'
		}.to change(Task, :count).by(1)

		expect(current_path).to eq(task_path(Task.last.id))
		expect(page).to have_content('Learn Rspec')
	end
end

feature 'Edit Task' do
	scenario 'user edits task' do
		task = create(:homework)

		visit task_path(task)

		click_link 'Edit'

		fill_in 'Name', with: 'Master Rspec'
		fill_in 'Priority', with: 2
		fill_in 'Due date', with: DateTime.now
		select(task.user.email, from: 'task_user_id')
		click_button 'Update Task'

		expect(current_path).to eq(task_path(task))
		expect(page).to have_content('Master Rspec')
	end
end