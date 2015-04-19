class Class

  def set_model(class_name, path_name = "")
    class_name = class_name.to_s # make sure it's a string
    var_name = ApplicationController.get_instance_variable_name(class_name)
    text_name = ApplicationController.get_text_name(class_name)
    path_name = var_name if path_name == nil or path_name == ""

    class_eval %Q{
      # POST /resource
      # POST /resource.json
      def create
        redirect_if_not_signed_in
        @#{var_name} = #{class_name}.new(#{var_name}_params)
        if params.has_key?(:task_session_id) and params[:task_session_id] != nil
          @#{var_name}.task_session_id = params[:task_session_id]
        elsif params.has_key?(:task_template_id) and params[:task_template_id] != nil
          @#{var_name}.task_template_id = params[:task_template_id]
        end

        respond_to do |format|
          if @#{var_name}.save
            format.html { redirect_to task_container_path, notice: "#{text_name} was successfully created." }
            format.json { render action: 'show', status: :created, location: @#{var_name} }
          else
            format.html { render action: 'new' }
            format.json { render json: @#{var_name}.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /resource/1
      # DELETE /resource/1.json
      def destroy
        @#{var_name}.destroy
        respond_to do |format|
          format.html { redirect_to task_container_path }
          format.json { head :no_content }
        end
      end

      # PATCH/PUT /resource/1
      # PATCH/PUT /resource/1.json
      def update
        respond_to do |format|
          if @#{var_name}.update(#{var_name}_params)
            format.html { redirect_to task_container_path, notice: '#{text_name} was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: #{path_name}s_path.errors, status: :unprocessable_entity }
          end
        end
      end
    }
  end

end
