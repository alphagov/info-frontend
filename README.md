# Info Frontend

This application exposes the user needs and metrics about content on GOV.UK. It does this by fetching content details from [Content Store](https://github.com/alphagov/content-store).

Information pages have a prefix of `/info`, for example: https://www.gov.uk/info/benefits-calculators and https://www.gov.uk/info/employers-sick-pay.

## Technical documentation

This is a Ruby on Rails app, and should follow [our Rails app conventions](https://docs.publishing.service.gov.uk/manual/conventions-for-rails-applications.html).

You can use the [GOV.UK Docker environment](https://github.com/alphagov/govuk-docker) or the local `startup.sh` script to run the app. Read the [guidance on local frontend development](https://docs.publishing.service.gov.uk/manual/local-frontend-development.html) to find out more about each approach, before you get started.

If you are using GOV.UK Docker, remember to combine it with the commands that follow. See the [GOV.UK Docker usage instructions](https://github.com/alphagov/govuk-docker#usage) for examples.

### Running the test suite

```
bundle exec rake
```

## License

[MIT License](LICENSE)
