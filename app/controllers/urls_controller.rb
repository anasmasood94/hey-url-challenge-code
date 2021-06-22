# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.all
  end

  def create
    url = Url.new(create_params)
    if url.save
      redirect_to root_url
    else
      raise "handle error"
    end
  end

  def show
    @url = Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now)
    # implement queries
    @daily_clicks = [
      ['1', 13],
      ['2', 2],
      ['3', 1],
      ['4', 7],
      ['5', 20],
      ['6', 18],
      ['7', 10],
      ['8', 20],
      ['9', 15],
      ['10', 5]
    ]
    @browsers_clicks = [
      ['IE', 13],
      ['Firefox', 22],
      ['Chrome', 17],
      ['Safari', 7]
    ]
    @platform_clicks = [
      ['Windows', 13],
      ['macOS', 22],
      ['Ubuntu', 17],
      ['Other', 7]
    ]
  end

  def visit
    url = Url.find_by_short_url(params["short_url"])
    if url.present?
      url.clicks.create(click_params)
      url.log_click
      redirect_to url.original_url
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
    def create_params
      params.require(:url).permit(:original_url).merge(created_at: Time.now)
    end

    def broswer
      @browser ||= Browser.new(request.env['HTTP_USER_AGENT'], accept_language: "en-us")
    end

    def click_params
      {
        browser: browser_name,
        platform: browser.platform
      }
    end

    def browser_name
      if browser.chrome?
        "Chrome"
      elsif browser.firefox?
        "Firefox"
      elsif browser.ie?
        "IE"
      elsif browser.opera?
        "Opera"
      elsif browser.safari?
        "Safari"
      else
        "Other"
      end
    end
end
