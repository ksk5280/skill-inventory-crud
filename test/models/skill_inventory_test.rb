require_relative '../test_helper'

class SkillInventoryTest < Minitest::Test
  include TestHelpers

  def create_skills(num)
    num.times do |i|
      skill_inventory.create(
        title:       "title#{i+1}",
        description: "description#{i+1}"
      )
    end
  end

  def test_it_creates_a_skill
    data = {
      :title => "a title",
      :description => "a description"
    }
    skill_inventory.create(data)
    skill = skill_inventory.all.last
    assert skill.id
    assert_equal "a title", skill.title
    assert_equal "a description", skill.description
  end

  def test_can_get_all_skills
    create_skills(2)
    skills = skill_inventory.all

    assert_equal 2, skills.count
    skill_inventory.all.each_with_index do |skill, index|
      assert_equal Skill, skill.class
      assert_equal "title#{index+1}", skill.title
      assert_equal "description#{index+1}", skill.description
    end
  end

  def test_can_find_skill_by_id
    create_skills(3)
    ids = skill_inventory.all.map { |skill| skill.id }

    ids.each_with_index do |id, index|
      skill = skill_inventory.find(id)
      assert_equal id, skill.id
      assert_equal "title#{index + 1}", skill.title
      assert_equal "description#{index + 1}", skill.description
    end
  end

  def test_can_update_existing_skill_data
    create_skills(3)
    data_new = {
      :title => "new title",
      :description => "new description"
    }
    id = skill_inventory.all.last.id

    skill_inventory.update(data_new, id)
    skill = skill_inventory.find(id)
    assert_equal "new title", skill.title
    assert_equal "new description", skill.description
  end

  def test_can_delete_skill_by_id
    create_skills(3)
    assert_equal 3, skill_inventory.all.count
    id = skill_inventory.all.last.id
    skill_inventory.delete(id)
    assert_equal 2, skill_inventory.all.count
  end
end
