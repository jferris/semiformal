@puts @announce @disable-bundler
Feature: generate an application and run rake

  Background:
    When I successfully run "rails new testapp"
    And I cd to "testapp"
    And I append to "Gemfile" with:
    """
    gem "thin"
    """
    When I add the "semiformal" gem from this project as a dependency
    And I successfully run "bundle install"
    And I configure a global route

  Scenario: simple form
    When I successfully run "rails generate model post title:string body:string"
    When I write to "app/controllers/posts_controller.rb" with:
    """
    class PostsController < ApplicationController
      def new
        @post = Post.new
        @form = Semiformal::Form.new(@post)
      end
    end
    """
    When I write to "app/views/posts/new.html.erb" with:
    """
    <%= render_form @form do |form| -%>
    <% end -%>
    """
    When I successfully run "rake db:migrate"
    And I start the application
    And I GET /posts/new
    Then the response should have the following "form" tag:
      | action | /posts |
      | method | post   |
    And the response should have the following "input" tag:
      | type  | hidden  |
      | name  | _method |
      | value | PUT     |

