require_relative '../test_helper'

class UserSeesAllSkillsTest < FeatureTest
  def test_on_home_page
    data1 = {
      title:       "some title",
      description: "some description"
    }
    skill_inventory.create(data1)

    data2 = {
      title:       "another title",
      description: "another description"
    }
    skill_inventory.create(data2)

    visit '/'
    click_link 'Skill Inventory'
    assert_equal '/skills', current_path
    assert page.has_content? 'some title'
    assert page.has_content? 'another title'
  end
end
