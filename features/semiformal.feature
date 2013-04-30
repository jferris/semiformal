@disable-bundler
Feature: generate an application and run rake

  Background:
    When I generate a new rails app
    And I append to "Gemfile" with:
    """
    gem "thin"
    """
    When I add the "semiformal" gem from this project as a dependency
    And I successfully run `bundle install --local`

  Scenario: simple form
    When I successfully run `bundle exec rails generate model post title:string body:string age:integer`
    When I write to "app/controllers/posts_controller.rb" with:
    """
    class PostsController < ApplicationController
      def new
        @post = Post.new
        assign_resource
        render
      end

      def create
        @post = Post.new
        assign_resource
        @post.attributes = resource_params
        @post.save!
        redirect_to [:edit, @post]
      end

      def edit
        @post = Post.find(params[:id])
        assign_resource
        render
      end

      def update
        @post = Post.find(params[:id])
        assign_resource
        @post.update_attributes!(resource_params)
        redirect_to [:edit, @post]
      end

      def assign_resource
        @resource = Semiformal::Resource.new(@post).accept(:title).accept(:age, :as => :integer)
      end

      def resource_params
        @resource.parse(params[:post])
      end
    end
    """
    When I write to "app/views/posts/_form.html.erb" with:
    """
    <%= render_form @resource do |form| -%>
      <%= form.inputs do -%>
        <%= form.input :title %>
      <% end -%>
      <%= form.buttons do -%>
        <%= form.commit_button %>
      <% end -%>
    <% end -%>
    """
    When I write to "app/views/posts/new.html.erb" with:
    """
    <%= render :partial => 'form' %>
    """
    When I write to "app/views/posts/edit.html.erb" with:
    """
    <%= render :partial => 'form' %>
    """
    When I route the "posts" resource
    When I successfully run `bundle exec rake db:migrate db:test:prepare`
    And I start the application
    And I visit /posts/new
    And I fill in "Title" with "example"
    And I press "Create Post"
    Then the "Title" field should contain "example"
    When I fill in "Title" with "changed"
    And I press "Update Post"
    Then the "Title" field should contain "changed"

