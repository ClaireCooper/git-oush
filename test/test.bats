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
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git config user.name "github-actions[bot]"
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

@test "git oush makes a new pre-push hook if one does not exist" {
    run git oush
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_contains .git/hooks/pre-push "git-oush"
}

@test "git oush adds git oush to existing pre-push hook" {
    echo "#bash" > .git/hooks/pre-push
    run git oush
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_contains .git/hooks/pre-push "git-oush"
    assert_file_contains .git/hooks/pre-push "#bash"
}

@test "multiple git oushes adds git oush to existing pre-push hook once only" {
    run git oush
    run git oush
    run git oush
    TEST_TEMP_DIR="$(temp_make)"
    EXPECTED_PATH="$TEST_TEMP_DIR/expected-pre-push"
    echo "git-oush" > $EXPECTED_PATH
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_files_equal .git/hooks/pre-push "$EXPECTED_PATH"
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

@test "git oush then git push removes git oush from hook" {
    run git oush
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_contains .git/hooks/pre-push "git-oush"
    run git push
    assert_file_exists .git/hooks/pre-push
    assert_file_executable .git/hooks/pre-push
    assert_file_not_contains .git/hooks/pre-push "git-oush"
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush --paddy plays Paddy sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --paddy
        assert_output -p 'paddy'
        assert_output -p '.wav 0.0'
        assert_success
    done
}

@test "git oush with --paddy and -f plays loud Paddy sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --paddy -f
        assert_output -p 'paddy'
        assert_output -p '.wav +20.0'
        assert_success
    done
    for ((i=0;i<10;i++))
    do
        run git oush -f --paddy
        assert_output -p 'paddy'
        assert_output -p '.wav +20.0'
        assert_success
    done
}

@test "git oush with --paddy and --force plays loud Paddy sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --paddy --force
        assert_output -p 'paddy'
        assert_output -p '.wav +20.0'
        assert_success
    done
    for ((i=0;i<10;i++))
    do
        run git oush --force --paddy
        assert_output -p 'paddy'
        assert_output -p '.wav +20.0'
        assert_success
    done
}

@test "git oush --matilda plays Matilda sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --matilda
        assert_output -p 'matilda'
        assert_output -p '.wav 0.0'
        assert_success
    done
}

@test "git oush with --matilda and -f plays loud Matilda sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --matilda -f
        assert_output -p 'matilda'
        assert_output -p '.wav +20.0'
        assert_success
    done
    for ((i=0;i<10;i++))
    do
        run git oush -f --matilda
        assert_output -p 'matilda'
        assert_output -p '.wav +20.0'
        assert_success
    done
}

@test "git oush with --matilda and -force plays loud Matilda sound" {
    for ((i=0;i<10;i++))
    do
        run git oush --matilda --force
        assert_output -p 'matilda'
        assert_output -p '.wav +20.0'
        assert_success
    done
    for ((i=0;i<10;i++))
    do
        run git oush --force --matilda
        assert_output -p 'matilda'
        assert_output -p '.wav +20.0'
        assert_success
    done
}

@test "git oush with both --matilda and --paddy plays a sound" {
    run git oush --matilda --paddy
    assert_output -p '.wav 0.0'
    assert_success
    run git oush --paddy --matilda
    assert_output -p '.wav 0.0'
    assert_success
}

@test "git oush with --matilda and --paddy and -f plays a loud sound" {
    run git oush --matilda --paddy -f
    assert_output -p '.wav +20.0'
    assert_success
    run git oush --matilda -f --paddy
    assert_output -p '.wav +20.0'
    assert_success
    run git oush -f --matilda --paddy
    assert_output -p '.wav +20.0'
    assert_success
}

@test "git oush with --matilda and --paddy and --force plays a loud sound" {
    run git oush --matilda --paddy --force
    assert_output -p '.wav +20.0'
    assert_success
    run git oush --matilda --force --paddy
    assert_output -p '.wav +20.0'
    assert_success
    run git oush --force --matilda --paddy
    assert_output -p '.wav +20.0'
    assert_success
}