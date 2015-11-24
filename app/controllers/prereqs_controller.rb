class PrereqsController < ApplicationController
    helper_method :valid_schedule?, :can_take?

    def can_take?(course, courses)
        prereq_dnf = course.prereq_string || ""
        classes_taken = courses.map{ |c| c.idstring}
        return true if prereq_dnf.empty?
        prereq_dnf.split('|',-1).any? { |arg| arg.split('&').all? { |classid| classes_taken.include? classid} }
    end

    def valid_schedule?(semesters)
        taken_classes = []
        invalid_classes = []
        for sem in semesters;
            semester_classes = []
            invalid_row = []
            for courseid in sem[1];
                if courseid == ""
                    invalid_row << ""
                    next
                end
                course = Course.find_by_idstring(courseid)
                if course != nil
                    if can_take?(course,taken_classes)
                        invalid_row << ""
                    else
                        invalid_row << course.prereq_string
                    end
                    semester_classes << course
                else
                    invalid_row << "NOT FOUND"
                end
                
            end
            taken_classes += semester_classes
            invalid_classes << invalid_row
        end
        return invalid_classes
    end


    def index
    end
    def create
        render :json => valid_schedule?(params[:courses])
    end
    def autocomplete
    end
end
