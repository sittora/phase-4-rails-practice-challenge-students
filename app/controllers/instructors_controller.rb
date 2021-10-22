class InstructorsController < ApplicationController
    # GET /instructors
    def index
        instructors = Instructor.all
        render json: instructors.to_json(except: [:created_at, :updated_at])
    end

    # GET /instructors/:id
    def show
        get_instructor
        if @instructor
          render json: @instructor.to_json(except: [:created_at, :updated_at])
        else
          render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
      rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
      end


    # PATCH /instructors/:id
  def update
    get_instructor
    puts "*********"
    puts "Instructor_params: #{instructor_params}"
    puts "*********"
    @instructor.update!(instructor_params)
      render json: @instructor
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  def destroy
    get_instructor
    @instructor.destroy!()
      render json: @instructor
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  private

  def get_instructor
    @instructor = Instructor.find_by(id: params[:id])
  end

  def instructor_params
    params.permit(:name)
  end
end
