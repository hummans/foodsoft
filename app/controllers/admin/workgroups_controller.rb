# encoding: utf-8
class Admin::WorkgroupsController < Admin::BaseController
  inherit_resources

  def index
    @workgroups = Workgroup.order('name ASC')
    # if somebody uses the search field:
    @workgroups = @workgroups.where('name LIKE ?', "%#{params[:query]}%") unless params[:query].blank?

    @workgroups = @workgroups.page(params[:page]).per(@per_page)
  end

  def destroy
    @workgroup = Workgroup.find(params[:id])
    @workgroup.destroy
    redirect_to admin_workgroups_url, :notice => "Arbeitsgruppe wurde gelöscht"
  rescue => error
    redirect_to admin_workgroups_url, :alert => "Arbeitsgruppe konnte nicht gelöscht werden: #{error}"
  end
end
