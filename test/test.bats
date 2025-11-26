#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'

    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$DIR/../bin:$DIR:$PATH"

    git init --bare mock_remote.git
    git clone mock_remote.git test_repo
    cd test_repo
    git commit -m "initial commit" --allow-empty
    git push
}

teardown() {
    cd ..
    rm -rf test_repo
    rm -rf mock_remote.git
}

@test "git oush plays sound" {
    run git oush
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush -f plays loud sound" {
    run git oush -f
    assert_output -p '.wav +20.0'
    assert_success
}

@test "git oush --force plays loud sound" {
    run git oush --force
    assert_output -p '.wav +20.0'
    assert_success
}

@test "git oush adds makes a new pre-push hook" {
    run git oush
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_contains .git/hooks/pre-push "play-oush"
}

@test "git oush adds git oush to pre-push hook" {
    echo "#bash" > .git/hooks/pre-push
    run git oush
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_contains .git/hooks/pre-push "play-oush"
    assert_file_contains .git/hooks/pre-push "#bash"
}

@test "git oush then git push plays sound" {
    run git oush
    run git push
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush -f then git push plays sound" {
    run git oush -f
    run git push
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush --force then git push plays sound" {
    run git oush --force
    run git push
    assert_output -p '.wav 0.0'
    assert_success
}
