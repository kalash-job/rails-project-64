[![Actions Status](https://github.com/kalash-job/rails-project-64/workflows/hexlet-check/badge.svg)](https://github.com/kalash-job/rails-project-64/actions)

[![Actions Status](https://github.com/kalash-job/rails-project-64/workflows/main/badge.svg)](https://github.com/kalash-job/rails-project-64/actions)

<h1>Project Collective blog.</h1>
<h2>About the project:</h2>
<p>This is the second project from the course Ruby on Rails developer by Hexlet.</p>
<p>The purpose of the project is to create a Collective blog, like Habr.com, but simpler.</p>
<p>Users without login can see posts, comments, and other users' likes.</p>
<p>Authenticated users additionally can create posts, and comments, and estimate all posts through likes.</p>
<p>Project error tracking is performed using Sentry.</p>
<p>This project is available on railway by the <a href="https://railsblog-production-14bf.up.railway.app/">link</a></p>
<h3>The main technologies used during project development were the following:</h3>
<ul>
<li>Ruby 3.1.2.</li>
<li>Ruby on Rails 7.</li>
<li>gem ancestry.</li>
<li>gem devise.</li>
<li>gem faker.</li>
<li>gem i18n.</li>
<li>gem minitest-power_assert.</li>
<li>gem simple_form.</li>
<li>gem slim-rails.</li>
<li>gem rubocop-rails.</li>
</ul>

<h2>Common instructions for local deployment:</h2>
<p>After <b>git clone</b> and <b>bundle install</b> commands you should execute the <b>make setup</b> command.</p>
<p>These actions will create a database structure locally and fill it with fake data. You can also run tests with the <b>make tests</b> command.</p>
<p>So after that, you can use the command <b>make start</b> and check the website working on <a href="http://127.0.0.1:3000">localhost</a>.</p>
