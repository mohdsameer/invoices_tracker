class InvoicesController < ApplicationController
  before_action :get_invoice, only: [:edit, :update, :destroy]

  def new
    @invoice = Invoice.new
  end

  def index
    if params[:from].present? && params[:to].present?
      @invoices = Invoice.filter(params[:from].to_date, params[:to].to_date)
    else
      @invoices = Invoice.all.order('invoice_date DESC')
    end
    @total = Invoice.total.round(2)
  end

  def create
    invoice = Invoice.new(invoice_params)
    if invoice.save
      flash[:notice] = "Invoice created successfully"
      redirect_to invoices_path
    else
      flash[:notice] = invoice.errors.full_messages.to_sentence
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      flash[:notice] = "Invoice updated successfully"
      redirect_to invoices_path
    else
      flash[:notice] = @invoice.errors.full_messages.to_sentence
      render action: "edit"
    end    
  end

  def destroy
    if @invoice.destroy
      flash[:notice] = "Invoice deleted successfully"
    else
      flash[:notice] = @invoice.errors.full_messages.to_sentence
    end
    redirect_to invoices_path
  end

  private

  def invoice_params
    params.require(:invoice).permit(:amount, :invoice_date)
  end

  def get_invoice
    @invoice ||= Invoice.find(params[:id])
  end
end
