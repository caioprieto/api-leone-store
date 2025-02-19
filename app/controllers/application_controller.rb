class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'leone')
  end

  def decode_token
    auth_header = request.headers['Authorization']

    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, 'leone', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def authorize
    render json: {message: 'Você precisa estar logado'}, status: :unauthorized unless authorized_user
  end

  def set_admin
    decoded_token = decode_token()

    if decoded_token
      admin_id = decoded_token[0]['admin_id']
      @admin = Admin.find_by(id: admin_id)
    end
  end

  def verify_admin
    render json: { message: "Você precisa ser administrador" } unless set_admin
  end
end
