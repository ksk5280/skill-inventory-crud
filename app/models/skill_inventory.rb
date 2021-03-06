class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def dataset
    database.from(:skills)
  end

  def create(skill)
    dataset.insert(skill)
  end

  def all
    dataset.to_a.map { |data| Skill.new(data)  }
  end

  def find(id)
    data = dataset.where(:id => id).to_a.first
    Skill.new(data)
  end

  def update(skill, id)
    dataset.where(:id => id).update(skill)
  end

  def delete(id)
    dataset.where(:id => id).delete
  end
end
