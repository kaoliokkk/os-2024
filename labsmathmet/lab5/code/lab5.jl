using Plots

# Размер сетки
nx = 100
ny = 100

# Создание сетки
x = 1:nx
y = 1:ny

# Визуализация сетки
#scatter(x, y, markersize = 1, aspect_ratio = 1, xlims = (1, nx), ylims = (1, ny), xlabel = "X", ylabel = "Y", legend = false)

# Параметры модели
delta = 0.1  # Порог кристаллизации
lambda = 0.1  # Капиллярная длина
dd = 0.1  # Амплитуда шума

# Инициализация сетки
u = zeros(nx, ny)
ksi = zeros(Int, nx, ny)  # Changed initialization to zeros

# Устанавливаем затравку в центре 3x3
center_x = Int(nx / 2)
center_y = Int(ny / 2)
ksi[center_x-1:center_x+1, center_y-1:center_y+1] .= 1

# Функция для проверки условия кристаллизации на периметре
function check_crystallization(u, ksi, i, j, delta, lambda, dd)
    neighbors = [(i+1, j), (i-1, j), (i, j+1), (i, j-1), (i+1, j+1), (i-1, j-1), (i+1, j-1), (i-1, j+1)]
    sum_omega = 0
    for (ni, nj) in neighbors
        if 1 <= ni <= nx && 1 <= nj <= ny
            omega = (abs(i - ni) + abs(j - nj) <= 1) ? 2 : 1
            sum_omega += omega * ksi[ni, nj]
        end
    end
    eta = rand() * 2 - 1
    return u[i, j] <= delta * (1 + dd * eta) + lambda * (sum_omega - 6)
end

# Моделирование роста дендритов
for i in 2:nx-1
    for j in 2:ny-1
        if ksi[i, j] == 0 && (ksi[i-1, j] == 1 || ksi[i+1, j] == 1 || ksi[i, j-1] == 1 || ksi[i, j+1] == 1)
            if check_crystallization(u, ksi, i, j, delta, lambda, dd)
                ksi[i, j] = 1
            end
        end
    end
end

# Визуализация результата
heatmap(ksi', aspect_ratio = 1, xlims = (1, nx), ylims = (1, ny), xlabel = "X", ylabel = "Y", color = :grays)