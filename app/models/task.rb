class Task < ApplicationRecord
	include Elasticsearch::Model
   	include Elasticsearch::Model::Callbacks
    belongs_to :user 
	# mappings dynamic: 'false' do
 #     indexes :title, type: 'string'
 #   end
  after_save :task_completion_check?
  validates :status, :inclusion => {:in => [1,2,3,4,5,6]}
   def as_indexed_json(options={})
  {
    "id" => id,
    "title" => name.downcase,
    "status" => status,
    "user_id" => user_id
  }
  end  

  def self.search(query)
    return Task.__elasticsearch__.search(query).results.as_json
  end

  def status_name
    name = {1 => "New", 2 => "In Progress", 3 => "Completed", 4 => "Expired", 5 => "Pending Approved", 6 => "Completed and Approved "}
    name[self.status]
  end

  def task_completion_check?
    if (self.status == 3)
      self.update_column(:status, 5)
    end
  end

  def approve
    self.update_column(:status, 6)
  end
end