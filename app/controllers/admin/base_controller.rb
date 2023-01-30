class Admin::BaseController < ApplicationController
  
  layout 'admin/layouts/application'
  before_action :require_admin
  # sessions_ctrlではskip_before_actionにしている

  def require_admin
    redirect_to questions_path unless current_user&.admin?
    # ログアウト状態で管理者ログインできても
    # current_userがnilになるためぼっち演算子へ変更
  end

end
