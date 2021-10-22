class StudentsController < ApplicationController
    # GET /students
    def index
        students = Student.all
        render json: students.to_json(except: [:created_at, :updated_at])
    end

    # GET /students/:id
    def show
        get_student
        if @student
          render json: @student.to_json(except: [:created_at, :updated_at])
        else
          render json: { error: "Student not found" }, status: :not_found
        end
    end

    def create
    student = Student.create!(student_params)
    render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    # PATCH /students/:id
  def update
    get_student
    @student.update!(student_params)
      render json: @student
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  def destroy
    get_student
    @student.destroy!()
      render json: @student
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  private

  def get_student
    @student = Student.find_by(id: params[:id])
  end

  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end
end
