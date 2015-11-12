# Improve vocabulary

It's a small application for improving vocabulary by repetition.

## Usage

    $ bin/improve_vocabulary

### Configuration

#### Lesson / Words

You can create your own lessons by creating a `YAML` file
(see [config/lesson1.yml]) and passing its path in `LESSON` env var. The
default is `config/lesson1.yml`

    $ bin/improve_vocabulary LESSON=config/your_lesson.yml

#### Times to repeat

You can configure how many times you want the words to repeat until they stop
appearing to you. You need to use `TIMES_TO_REPEAT` env var to set it up.
The default is `3`.

    $ bin/improve_vocabulary TIMES_TO_REPEAT=10
