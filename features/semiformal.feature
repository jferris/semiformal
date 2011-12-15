@disable-bundler
Feature: generate an application and run rake

  Background:
    When I successfully run `rails new testapp`
    And I cd to "testapp"
    And I append to "Gemfile" with:
    """
    gem "thin"
    """
    When I add the "semiformal" gem from this project as a dependency
    And I successfully run `bundle install`

  Scenario: simple form
    When I successfully run `rails generate model post title:string body:string`
    When I write to "app/controllers/posts_controller.rb" with:
    """
    class PostsController < ApplicationController
      def new
        @post = Post.new
        assign_resource
        render
      end

      def create
        assign_resource
        @post = Post.new(resource_params)
        @post.save!
        redirect_to [:edit, @post]
      end

      def edit
        @post = Post.find(params[:id])
        assign_resource
        render
      end

      def update
        assign_resource
        @post = Post.find(params[:id])
        @post.update_attributes!(resource_params)
        redirect_to [:edit, @post]
      end

      def assign_resource
        @resource = Semiformal::Resource.new(@post).accept(:title)
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
    When I successfully run `rake db:migrate db:test:prepare`
    And I start the application
    And I visit /posts/new
    And I fill in "Title" with "example"
    And I press "Create Post"
    Then the "Title" field should contain "example"
    When I fill in "Title" with "changed"
    And I press "Update Post"
    Then the "Title" field should contain "changed"

