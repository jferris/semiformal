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

  Scenario: simple form
    When I successfully run "rails generate model post title:string body:string"
    When I write to "app/controllers/posts_controller.rb" with:
    """
    class PostsController < ApplicationController
      def new
        @post = Post.new
        @form = Semiformal::Form.new(self, @post)
        render
      end

      def create
        render :text => params[:post][:title].inspect
      end
    end
    """
    When I write to "app/views/posts/new.html.erb" with:
    """
    <%= render_form @form do |form| -%>
      <%= form.inputs do -%>
        <%= form.input :title %>
      <% end -%>
      <%= form.buttons do -%>
        <%= form.commit_button %>
      <% end -%>
    <% end -%>
    """
    When I route the "posts" resource
    When I successfully run "rake db:migrate db:test:prepare"
    And I start the application
    And I visit /posts/new
    And I fill in "Title" with "example"
    And I press "Create Post"
    Then I should see "example"

