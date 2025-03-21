class Task < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: true

  enum status: { pending: "pending", completed: "completed" }

  def mark_completed!
    update(status: "completed", completed_at: Time.current)
  end
end
