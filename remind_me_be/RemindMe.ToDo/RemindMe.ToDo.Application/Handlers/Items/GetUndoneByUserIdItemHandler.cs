﻿using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetUndoneByUserIdItemHandler : IRequestHandler<GetActiveItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetUndoneByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public Task<IQueryable<Item>> Handle(GetActiveItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetUndoneItemsByUserId(request.UserId);
            return result;
        }
    }
}
